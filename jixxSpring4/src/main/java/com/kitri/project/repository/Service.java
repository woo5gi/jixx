package com.kitri.project.repository;

import java.util.ArrayList;
import java.util.Map;

import vo.Channel;
import vo.Member;
import vo.Repository;
import vo.UserMeta;
import vo.UserMeta2;

public interface Service {
	Repository selectRepByUrl(String url);

	void addRep(Repository r);

	Repository getRepository(Repository r);

	void createCh(Repository r);

	void createCh(String chtitle, int rep_id);

	Channel getChId(Repository rep_id);	

	void createUserMeta(int id, int rep_id1, int chid1);

	void createUserMetaCreateChannel(ArrayList<Integer> useridlist, int rep_id, int chid);
	void createUserMetaCreateChannel1(int user_id, int rep_id, int chid);

	void createUserMetaInvite(int id, int rep_id, int ch_id);

	void addBoard(String nickname, int id, int chid1);

	Member getMember(int id);

	void addMember(String email, String pwd, String name);

	int getRepIdByRepNameUserMeta(String rep_name);

	ArrayList<Integer> getChIdList(int rep_id);

	ArrayList<Channel> getChList(int rep_id);

	Member getMember(String email);

	ArrayList<Integer> getUserList(int rep_id);

	ArrayList<String> getUserNameList(ArrayList<Integer> userlist);

	ArrayList<String> getRepNameListById(int id);

	void setUserMeta2Invite(int id, int rep_id, String nickname);

	String getNickname(int id, int rep_id);
	Channel getChannel(int rep_id);
	Channel getMaxChannel(int rep_id);
	Repository getRepository(int rep_id);
	ArrayList<String> getNicknameList(int rep_id);

	ArrayList<Integer> getRepIdList(String search);

	ArrayList<String> getUserNameListByRepId(ArrayList<Integer> repidlist);

	/* String getRepNameById(int id); */

	void editRep(Repository r);

	void delRep(int rep_id);

	ArrayList<String> getRepNameListById(String search);

	ArrayList<UserMeta> getUserMeatList(int id, int rep_id);

	void setUserMeta2Create(int id, int rep_id2, String nickname);

	int getUserAdminLevel(int id, int rep_id);

	ArrayList<UserMeta2> getUserMeta2List(int rep_id);

	void deleteChannel(int ch_id);

	Member getMemberAll(int id);

	





	

	

	



}
