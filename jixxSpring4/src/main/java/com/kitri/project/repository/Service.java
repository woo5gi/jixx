package com.kitri.project.repository;

import java.util.ArrayList;
import java.util.Map;

import vo.Channel;
import vo.Member;
import vo.Repository;

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

	ArrayList<Integer> getChList(int rep_id);

	ArrayList<String> getChNameList(int rep_id);

	Member getMember(String email);

	ArrayList<Integer> getUserList(int rep_id);

	ArrayList<String> getUserNameList(ArrayList<Integer> userlist);

	ArrayList<String> getRepNameListById(int id);

	void setUserMeta2(int id, int rep_id, String nickname);

	String getNickname(int id, int rep_id);
	Channel getChannel(int rep_id);
	Repository getRepository(int rep_id);
	ArrayList<String> getNicknameList(int rep_id);

	/* String getRepNameById(int id); */

	void editRep(Repository r);

	void delRep(int rep_id);



	

	

	



}
