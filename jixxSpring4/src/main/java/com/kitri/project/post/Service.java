package com.kitri.project.post;

import java.util.ArrayList;

import vo.Channel;
import vo.Post;

public interface Service {
	void write(Post post);
	ArrayList<Post> show(int page, int cn);
	Post change(Post post);
	void delete(int Post_id);
	Channel getChannel(int cn);
	ArrayList<String> getNicknameList(int rep_id);
	ArrayList<Channel> getChList(int rep_id);
	String getNickname(int id);
}
