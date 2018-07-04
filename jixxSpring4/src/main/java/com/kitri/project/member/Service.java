package com.kitri.project.member;

import java.util.ArrayList;

import vo.Member;

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

	

	
	

}
