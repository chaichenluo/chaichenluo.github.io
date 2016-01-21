---
layout: post
title: "Beer bottle lid"
description: ""
category: 
tags: []
---
{% include JB/setup %}

##酒干倘卖无之递归算法

还记得那首老歌么，它蕴含着一个多么辛酸的故事，生活不易，勤俭节约资源回收再利用吧！

###题目：

* 啤酒2元1瓶，4个瓶盖换一瓶，2个空瓶换1瓶
* 问：100块钱可以喝多少瓶

###递归算法实现：

	#define N	5
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

