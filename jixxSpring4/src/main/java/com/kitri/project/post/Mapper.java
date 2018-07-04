package com.kitri.project.post;

import java.util.ArrayList;
import java.util.Map;

import vo.Channel;
import vo.Post;

public interface Mapper {
	void insert(Post post);
	ArrayList<Post> selectAll(Map<String, Integer> map);
	Post update(Post post);
	void delete(int post_id);
	Channel selectChannel(int cn);
	ArrayList<String> selectNicknameList(int rep_id);
	ArrayList<Channel> selectChList(int rep_id);
	String selectNickname(int id);
}
