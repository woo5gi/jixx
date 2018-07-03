package com.kitri.project.post;

import java.util.ArrayList;

import vo.Channel;
import vo.Post;

public interface Service {
	public void write(Post post);
	public ArrayList<Post> show(int page, int cn);
	public Post change(Post post);
	public void delete(int Post_id);
	public Channel getChannel(int cn);
}
