package com.kitri.project.post;

import java.util.ArrayList;

import vo.Channel;
import vo.Member;
import vo.Post;
import vo.Repository;

public interface Service {
	void write(Post post);
	ArrayList<Post> show(int page, int cn);
	Post change(Post post);
	void delete(int Post_id);
	Channel getChannel(int cn);
	ArrayList<String> getNicknameList(int rep_id);
	ArrayList<Channel> getChList(int rep_id);
	String getNickname(int id,int rep_id);
	Member getMember(int id);
	Repository getRepository(int rep_id);
}
