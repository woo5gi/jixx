package com.kitri.project.member;

import java.util.ArrayList;
import java.util.Map;

import vo.Channel;
import vo.Member;
import vo.Repository;
import vo.UserMeta2;

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

	void delRepository(int rep_id);

	Member selectMemberAll(int id);

	UserMeta2 selectUserMeta2(Map<String, Object> map);

	void editUM2(UserMeta2 um2);

	Channel selectChannel(int rep_id);

	Repository selectRepository(int rep_id);

	

		


}
