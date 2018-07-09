package com.kitri.project.post;

import java.util.ArrayList;
import java.util.Map;

import vo.Channel;
import vo.Member;
import vo.Post;
import vo.Repository;
import vo.UserMeta;

public interface Mapper {
	void insert(Post post);
	ArrayList<Post> selectAll(Map<String, Integer> map);
	ArrayList<Post> selectAllMore(Map<String, Integer> map);
	ArrayList<Post> selectSearchResult(Map<String, Object> map);
	ArrayList<Post> selectSearchResultMore(Map<String, Object> map);
	void update(Map<String, Object> map);
	void delete(int post_id);
	Channel selectChannel(int cn);
	ArrayList<String> selectNicknameList(int rep_id);
	ArrayList<Channel> selectChList(int rep_id);
	String selectNickname(Map<String, Object> map);
	Member selectMember(int id);
	Repository selectRepository(int rep_id);
	int selectFirstChannelId(int rep_id);
	ArrayList<String> selectRepList(int id);
	ArrayList<Post> selectRepost(ArrayList<Post> list);
	
	int selectUserAdminLevel(Map<String, Object> map);
	void repostInsert(Post post);
	int selectRepostID(int user_id);
	UserMeta selectUserMeta(Map<String, Object> map);
	ArrayList<Integer> selectMemberId(Map<String, Object> map);
	ArrayList<String> selectMemberEmail(Map<String, Object> map);
	
}
