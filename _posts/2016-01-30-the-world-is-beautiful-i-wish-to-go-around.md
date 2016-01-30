---
layout: post
title: "The world is beautiful, I wish to go around"
description: ""
category: 
tags: []
---
{% include JB/setup %}


### The world is beautiful, I wish to go around through the smartshadowsocks.

	public static void UpdatePassword(Configuration config)
	{
	    String utf8StringPass = null;
	    String unicodeStringPass = null;
	
	    if (0 == String.Compare(config.configs[config.index].server, "server1.com", true))
	    {
	        config.configs[config.index].server = "us1.iss.tf";
	        config.configs[config.index].server_port = 443;
	        config.configs[config.index].method = "aes-256-cfb";
	
	        utf8StringPass = "A密码";
	    }
	    else if (0 == String.Compare(config.configs[config.index].server, "server2.com", true))
	    {
	        config.configs[config.index].server = "us2.iss.tf";
	        config.configs[config.index].server_port = 8989;
	        config.configs[config.index].method = "aes-256-cfb";
	
	        utf8StringPass = "B密码";
	    }
	    else if (0 == String.Compare(config.configs[config.index].server, "server3.com", true))
	    {
	        config.configs[config.index].server = "jp3.iss.tf";
	        config.configs[config.index].server_port = 443;
	        config.configs[config.index].method = "aes-256-cfb";
	
	        utf8StringPass = "C密码";
	    }
	    else if (0 == String.Compare(config.configs[config.index].server, "server4.com", true)){
	        config.configs[config.index].server = "208.64.31.103";
	        config.configs[config.index].server_port = 33890;
	        config.configs[config.index].method = "RC4-MD5";
	
	        unicodeStringPass = "208.64.31.103";
	    }
	    else if (0 == String.Compare(config.configs[config.index].server, "server5.com", true))
	    {
	        config.configs[config.index].server = "104.128.228.147";
	        config.configs[config.index].server_port = 33890;
	        config.configs[config.index].method = "RC4-MD5";
	
	        unicodeStringPass = "104.128.228.147";
	    }
	    else if (0 == String.Compare(config.configs[config.index].server, "server6.com", true))
	    {
	        config.configs[config.index].server = "192.243.117.164";
	        config.configs[config.index].server_port = 33890;
	        config.configs[config.index].method = "RC4-MD5";
	
	        unicodeStringPass = "192.243.117.164";
	    }
	
	    String defaultStringPass = "";
	
	    WebRequest request = null;
	    HttpWebResponse response=null;
	    Stream dataStream = null;
	    StreamReader reader = null;
	    string responseFromServer = null;
	
	    if (utf8StringPass != null)
	    {
	        request = WebRequest.Create("http://www.ishadowsocks.com/");     // Create a request for the URL.
	
	        request.Credentials = CredentialCache.DefaultCredentials;           // If required by the server, set the credentials.
	        response = (HttpWebResponse)request.GetResponse();  //MessageBox.Show(response.StatusDescription);            Console.WriteLine(response.StatusDescription);
	        dataStream = response.GetResponseStream();          // Get the stream containing content returned by the server.
	        reader = new StreamReader(dataStream, Encoding.Default);   // Open the stream using a StreamReader for easy access.
	        responseFromServer = reader.ReadToEnd();         // Read the content.
	
	        Encoding utf8 = Encoding.UTF8;
	        Encoding defaultCode = Encoding.Default;
	        byte[] bufferIn = Encoding.Default.GetBytes(utf8StringPass);
	        byte[] bufferOut = Encoding.Convert(Encoding.Default, Encoding.UTF8, bufferIn, 0, bufferIn.Length);
	
	        defaultStringPass = Encoding.Default.GetString(bufferOut, 0, bufferOut.Length);
	
	    }
	    else if (unicodeStringPass != null)
	    {
	        string strText = "%E4%B8%96%E7%95%8C%E5%A4%9A%E7%BE%8E%E5%A5%BD%E6%88%91%E6%83%B3%E5%8E%BB%E7%9C%8B%E7%9C%8B1";     // "世界多美好我要去看看";
	        string strAuthor = "qukankan";
	        string strMail = "qukankan%40gmail.com";        // "qukankan@gmail.com";
	        string strUrl = "www.qukankan.com";
	
	        ASCIIEncoding encoding = new ASCIIEncoding();
	        string postData = "text=" + strText;
	        postData += ("&author=" + strAuthor);
	        postData += ("&mail=" + strMail);
	        postData += ("&url=" + strUrl);
	        postData += ("&submit=%E6%8F%90%E4%BA%A4&filter_spam=48616E6E79&_=42e4d80a3d0b6b191d7988b11b96f677");
	
	        byte[] data = encoding.GetBytes(postData);
	
	        // Prepare web request...  
	        HttpWebRequest myRequest = (HttpWebRequest)WebRequest.Create("http://fyhqy.com/356/comment");
	
	        myRequest.Method = "POST";
	        myRequest.ContentType = "application/x-www-form-urlencoded";
	        myRequest.Referer = "http://fyhqy.com/356/comment-page-1";
	        myRequest.ContentLength = data.Length;
	
	        string host = "http://fyhqy.com";
	        CookieContainer cc = new CookieContainer();
	        cc.Add(new Uri(host), new Cookie("CNZZDATA962768", "cnzz_eid%3D934427574-1454084572-%26ntime%3D1454120708"));
	        cc.Add(new Uri(host), new Cookie("Hm_lvt_7f69b05e993f03fb2d4ce7c762c28dbb", "1454084724"));
	        cc.Add(new Uri(host), new Cookie("Hm_lpvt_7f69b05e993f03fb2d4ce7c762c28dbb", "1454125139"));
	        cc.Add(new Uri(host), new Cookie("df7f82be9fc37a2a5cffbe412147989b__typecho_remember_author", "qukankan"));
	        cc.Add(new Uri(host), new Cookie("df7f82be9fc37a2a5cffbe412147989b__typecho_remember_mail", "qukankan%40gmail.com"));
	        cc.Add(new Uri(host), new Cookie("df7f82be9fc37a2a5cffbe412147989b__typecho_remember_url", "http%3A%2F%2Fwww.qukankan.com"));
	        myRequest.CookieContainer = cc;
	
	        Stream newStream = myRequest.GetRequestStream();
	
	        // Send the data.  
	        newStream.Write(data, 0, data.Length);
	       // newStream.Close();
	
	        // Get response  
	        response = (HttpWebResponse)myRequest.GetResponse();
	        dataStream = response.GetResponseStream();
	        reader = new StreamReader(dataStream, Encoding.Default);
	        responseFromServer = reader.ReadToEnd();        // Console.WriteLine(content);
	
	
	        defaultStringPass = "password";
	
	    }
	
	
	    int i = responseFromServer.IndexOf(defaultStringPass);   // ("密码");
	    if (i < 0) {
	        reader.Close();
	        dataStream.Close();
	        response.Close();
	        MessageBox.Show("Password not found");
	        return;
	    }
	    i = responseFromServer.IndexOf(":", i);   // ("密码");
	    if (i >= 0){
	        string dataBid = null;
	        if (utf8StringPass != null)
	        {
	            dataBid = responseFromServer.Substring(i + 1, 8);
	        }
	        else if (unicodeStringPass != null)
	        {
	            dataBid = responseFromServer.Substring(i + 2, 19);
	        }
	        config.configs[config.index].password = dataBid;
	    }
	    String strBuf = String.Concat("password:", config.configs[config.index].password);
	    MessageBox.Show(I18N.GetString(strBuf));
	    // Cleanup the streams and the response.
	    reader.Close();
	    dataStream.Close();
	    response.Close();
	}