---
layout: post
title: "Beer bottle lid"
description: ""
category: 
tags: []
---
{% include JB/setup %}

## 酒干倘卖无之递归算法

还记得那首老歌么，它蕴含着一个多么辛酸的故事，生活不易，勤俭节约资源回收再利用吧！

### 题目：

* 啤酒2元1瓶，4个瓶盖换一瓶，2个空瓶换1瓶
* 问：100块钱可以喝多少瓶？

### 递归算法实现：

	#define N	50
	int total = 0;
	int round = 0;
	
	void beer_bottle_lid(int beer, int bottle, int lid)
	{
		round++;
		printf ("第%d轮：喝了%d瓶酒，剩下%d个空瓶子，剩下%d个瓶盖子\n", round, beer, bottle, lid);
		
		int beer1 = (bottle)/2;
		int beer2 = (lid)/4;
		int bot = (bottle)%2;
		int li = (lid)%4;
	
		int new_beer = (beer1+beer2);
		int new_bottle = (new_beer+bot);
		int new_lid = (new_beer+li);
	
		total += new_beer;	
	
		if (new_beer == 0){
			return;
		}
		
		beer_bottle_lid(new_beer, new_bottle, new_lid);
		
	
	}
	//---------------------------
	int main(void)
	{
		total += N;
		beer_bottle_lid(N, N, N);
		
		printf ("\n\r总共喝了瓶酒，也是醉了！\n", total);
		return 0;
	}

### 测试结果

	第1轮:喝了50瓶酒,剩下50个空瓶子,剩下50个瓶盖子
	第2轮:喝了37瓶酒,剩下37个空瓶子,剩下39个瓶盖子
	第3轮:喝了27瓶酒,剩下28个空瓶子,剩下30个瓶盖子
	第4轮:喝了21瓶酒,剩下21个空瓶子,剩下23个瓶盖子
	第5轮:喝了15瓶酒,剩下16个空瓶子,剩下18个瓶盖子
	第6轮:喝了12瓶酒,剩下12个空瓶子,剩下14个瓶盖子
	第7轮:喝了9瓶酒,剩下9个空瓶子,剩下11个瓶盖子
	第8轮:喝了6瓶酒,剩下7个空瓶子,剩下9个瓶盖子
	第9轮:喝了5瓶酒,剩下6个空瓶子,剩下6个瓶盖子
	第10轮:喝了4瓶酒,剩下4个空瓶子,剩下6个瓶盖子
	第11轮:喝了3瓶酒,剩下3个空瓶子,剩下5个瓶盖子
	第12轮:喝了2瓶酒,剩下3个空瓶子,剩下3个瓶盖子
	第13轮:喝了1瓶酒,剩下2个空瓶子,剩下4个瓶盖子
	第14轮:喝了2瓶酒,剩下2个空瓶子,剩下2个瓶盖子
	第15轮:喝了1瓶酒,剩下1个空瓶子,剩下3个瓶盖子
	
	总共喝了195瓶酒,也是醉了