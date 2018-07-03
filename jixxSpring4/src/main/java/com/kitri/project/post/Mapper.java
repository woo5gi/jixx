package com.kitri.project.post;

import java.util.ArrayList;
import java.util.Map;

import vo.Channel;
import vo.Post;

public interface Mapper {
	public void insert(Post post);
	public ArrayList<Post> selectAll(Map<String, Integer> map);
	public Post update(Post post);
	public void delete(int post_id);
	public Channel selectChannel(int cn);
}
