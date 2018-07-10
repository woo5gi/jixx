package com.kitri.project.repository;

import java.util.ArrayList;
import java.util.Map;

import vo.Channel;
import vo.Member;
import vo.Post;
import vo.Repository;
import vo.UserMeta;
import vo.UserMeta2;

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

	ArrayList<Integer> selectChIdList(int rep_id);

	ArrayList<Channel> selectChList(int rep_id);

	Member selectUserIdByEmail(String email);

	ArrayList<Integer> selectUserList(int rep_id);

	ArrayList<String> selectUserNameList(Map<String, Object> map);

	Repository selectRepository(int rep_id);

	ArrayList<String> selectRepList(int id);

	void insertUserMeta2Invite(Map<String, Object> map);

	String selectNickname(Map<String, Object> map);

	Channel selectChannel(int rep_id);	

	ArrayList<String> selectNicknameList(int rep_id);

	ArrayList<Integer> selectRepBySearch(String search);
	ArrayList<String> selectRepNameBySearch(String search);
	ArrayList<String> selectrepNameList(Map<String, Object> map);

	void update(Repository r);

	void delete(int rep_id);

	ArrayList<UserMeta> selectUserMetaList(Map<String, Object> map);

	Channel selectMaxChannel(int rep_id);

	void insertUserMeta2Create(Map<String, Object> map);

	int selectAdminLevel(Map<String, Object> map);

	ArrayList<UserMeta2> selectUserMeta2(int rep_id);

	void deleteCh(int ch_id);

	Member selectMember(int id);

	void deleteUserMeta(Map<String, Object> map);

	void deleteUserMeta2(Map<String, Object> map);

	void updateAdminLevel(UserMeta2 um2);

	void plusAlarmCheck(Map<String, Object> map);

	void minusAlarmCheck(Map<String, Object> map);

	ArrayList<String> selectNicknameListByUserList(Map<String, Object> map);





}
