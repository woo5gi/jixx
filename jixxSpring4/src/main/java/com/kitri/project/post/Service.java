package com.kitri.project.post;

import java.util.ArrayList;

import vo.Channel;
import vo.Member;
import vo.Post;
import vo.Repository;
import vo.UserMeta;

public interface Service {
	void write(Post post);

	ArrayList<Post> show(int page, int cn);

	ArrayList<Post> showMore(int page, int cn);
	
	ArrayList<Post> getSearchBoard(int page, int rep_id, String search);

	ArrayList<Post> getSearchBoardMore(int page, int rep_id, String search);
	
	void change(String content, int post_id);

	void delete(int Post_id);

	Channel getChannel(int cn);

	ArrayList<String> getNicknameList(int rep_id);

	ArrayList<Channel> getChList(int rep_id);

	String getNickname(int id, int rep_id);

	Member getMember(int id);

	Repository getRepository(int rep_id);

	int getFirstChannelId(int rep_id);

	ArrayList<String> getRepNameListById(int id);

	ArrayList<Post> getRepost(ArrayList<Post> list);
	int getUserAdminLevel(int id, int rep_id);

	ArrayList<Integer> getMemberId(int cn,int id);

	ArrayList<String> getMemberEmail(ArrayList<Integer> idlist);

	ArrayList<Integer> getAlarmType(int id, int rep_id, int[] chidlist);

}
