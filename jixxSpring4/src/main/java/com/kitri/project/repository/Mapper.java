package com.kitri.project.repository;

import java.util.ArrayList;
import java.util.Map;

import vo.Channel;
import vo.Member;
import vo.Repository;

public interface Mapper {

	Repository getRepositoryByUrl(String url);

	void insertRep(Repository r);

	Repository selectRepByRep(Repository r);

	void insertCh(Repository r);

	void insertCh2(Map<String, Object> map);

	Channel getChByRepId(Repository rep_id);	

	void insertUserMeta(Map<String, Object> map);

	void insertUserMetaCreateChannel(Map<String, Object> map);

	void insertUserMetaCreateChannel1(Map<String, Object> map);

	void insertUserMetaInvite(Map<String, Object> map);

	void insertBoard(Map<String, Object> map);

	Member getNameById(int id);

	void insertMember(Map<String, Object> map);

	int selectRepIdByRepNameUserMeta(String rep_name);

	ArrayList<Integer> selectChList(int rep_id);

	ArrayList<String> selectChNameList(int rep_id);

	Member selectUserIdByEmail(String email);

	ArrayList<Integer> selectUserList(int rep_id);

	ArrayList<String> selectUserNameList(Map<String, Object> map);

	Repository selectRepository(int rep_id);

	ArrayList<String> selectRepList(int id);

	void insertUserMeta2(Map<String, Object> map);

	String selectNickname(Map<String, Object> map);

	Channel selectChannel(int rep_id);

	void update(Repository r);

	void delete(int rep_id);

	ArrayList<String> selectNicknameList(int rep_id);

}
