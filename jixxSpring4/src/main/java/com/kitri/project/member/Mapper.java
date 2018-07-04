package com.kitri.project.member;

import java.util.ArrayList;
import java.util.Map;

import vo.Member;

public interface Mapper {
	void insert(Member m);

	Member select(int id);

	void update(Member m);

	void delete(int id);

	Member selectMemberByEmail(String email);
	
	void verify(Member m);
	
	void verifyByEmail(String email);

	void setTempkey(Map<String, Object> map);
	
	void setTempkeyByEmail(Map<String, Object> map);

	int selectTempKey(String email);

	void setNewPass(Member m);

	ArrayList<String> selectRepList(int id);

	

		


}
