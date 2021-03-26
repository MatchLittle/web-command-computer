package com.order.order;

import org.springframework.web.bind.annotation.*;
import redis.clients.jedis.Jedis;

/**
 * @author nan
 * @date 2020/7/27 23:25
 */
@RestController
@RequestMapping("sys/order")
public class orderController {
	/**
	 * 连接redis，写入数据接口，读取数据接口
	 */
	 
	/**
	 * 连接本地的 Redis 服务
	 */
	Jedis jedis = new Jedis("http://localhost:6379");


	/**
	 * 页面端传来order存入redis，并返回存储结果
	 * @param order
	 * @return
	 */
	@CrossOrigin
	@GetMapping("updateOrder")
	public boolean innerOrder(@RequestParam("order") String order){
		//设置传来的命令到Redis里
		try{
			jedis.set("Order",order);
			//判断是否存储成功，成功返回true，失败返回false
			if(jedis.exists("Order")){
				System.out.println(new Date()+" Insert "+order);
				return true;
			}
		}catch (Exception e){
			System.out.println(e.getMessage());
		}

		return false;
	}

	/**
	 * 请求这个接口，会返会当前被前端设置的命令。电脑拿到命令之后会无条件执行
	 * @return
	 */
	@CrossOrigin
	@GetMapping("getOrder")
	public String backOrder(){
		try{
			return jedis.get("Order");
		}catch (Exception e){
			System.out.println(e.getMessage());
		}

	}
	
	/**
   * 未完成部分
   * 在线监测部分，根据电脑端的请求，将在线的信息写到redis里面，页面根据请求的值判断电脑是否在线
   * 接收到电脑的请求，将电脑的在线信息写入到redis，通过定时任务监测请求的获取信息，若是获取不到请求信息，
   * 将redis的在线信息改为离线
   * status
   * online在线
   * noline不在线
   * @return
   */
  @CrossOrigin
  @GetMapping("putOnline")
  public String putOnline(HttpServletRequest request) {
		try{
			//利用两次获取命令得时间差获取
			String str1 = "";
			String str2 = "";

			final StringBuffer[] str = {request.getRequestURL()};

			new Timer("testTimer").schedule(new TimerTask() {
				@Override
				public void run() {
					jedis.set("status",str[0].toString());
					System.out.println(new Date()+" Get " + str[0]);
					str[0] = null;
				}
                }, 2000,3000);

			return jedis.get("status");
		}catch (Exception e){
			System.out.println(e.getMessage());
		}
		return "Get Fail";
	}

	/**
	 * 未完成部分
	 * 获取电脑的在线情况，页面根据请求的值判断电脑是否在线
	 * online在线
	 * noline不在线
	 * @return
	 */
	@CrossOrigin
	@GetMapping("getOnline")
	public String getOnline(){
		try{
			System.out.println(new Date()+" Get "+jedis.get("Order"));
			return jedis.get("status");
		}catch (Exception e){
			System.out.println(e.getMessage());
		}
		return "noline";
	}


}
