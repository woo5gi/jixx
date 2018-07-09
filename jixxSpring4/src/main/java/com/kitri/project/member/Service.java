package com.kitri.project.member;

import java.util.ArrayList;

import vo.Channel;
import vo.Member;
import vo.UserMeta2;

public interface Service {
	void addMember(Member m);

	Member getMemberId(int id);
	
	Member getMemberByEmail(String email);

	void editMember(Member m);

	void delMember(int id);	
	
	void verifyMember(Member m);

	void setTempkey(int ran2, int id);
	
	void setTempkey(int ran2, String email);	

	int selectTempKey(String email);

	void verifyMemberByEmail(String email);

	void setNewPass(Member m);

	ArrayList<String> getRepNameListById(int id);

	void delRepository(int rep_id);

	Member getMember(int id);

	UserMeta2 getUserMeta2(int id, int rep_id);

	void editUM2(UserMeta2 um2);

	Channel getChannel(int rep_id);	

}
