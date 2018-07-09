package com.kitri.project.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import vo.Channel;
import vo.Member;
import vo.Repository;
import vo.UserMeta;
import vo.UserMeta2;

@Component("repService")
public class ServiceImpl implements Service {
	@Resource(name = "sqlSession")
	private SqlSession sqlSession;
	private Mapper repMapper;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public Repository selectRepByUrl(String url) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Repository r = repMapper.getRepositoryByUrl(url);
		return r;
	}

	@Override
	public void addRep(Repository r) {
		repMapper = sqlSession.getMapper(Mapper.class);
		repMapper.insertRep(r);
	}

	@Override
	public Repository getRepository(Repository r) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Repository r2 = repMapper.selectRepByRep(r);
		return r2;
	}

	@Override
	public void createCh(Repository r) {
		repMapper = sqlSession.getMapper(Mapper.class);
		repMapper.insertCh(r);
	}
	@Override
	public void createCh(String chtitle,int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("chtitle", chtitle);
		map.put("rep_id", rep_id);
		repMapper.insertCh2(map);
	}
	

	@Override
	public Channel getChId(Repository rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Channel ch = repMapper.getChByRepId(rep_id);
		return ch;
	}
	

	@Override
	public void createUserMeta(int id, int rep_id1, int chid1) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", id);
		map.put("rep_id", rep_id1);
		map.put("ch_id", chid1);
		repMapper.insertUserMeta(map);
	}

	@Override
	public void createUserMetaCreateChannel(ArrayList<Integer> useridlist, int rep_id, int chid) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", useridlist);
		map.put("rep_id", rep_id);
		map.put("ch_id", chid);
		System.out.println("useridlist:"+useridlist+";;rep_id="+rep_id+";;chid="+chid);
		repMapper.insertUserMetaCreateChannel(map);
	}
	@Override
	public void createUserMetaCreateChannel1(int user_id, int rep_id, int chid) {
		repMapper = sqlSession.getMapper(Mapper.class);		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", user_id);
		map.put("rep_id", rep_id);
		map.put("ch_id", chid);
		repMapper.insertUserMetaCreateChannel1(map);
		
	}


	
	@Override
	public void createUserMetaInvite(int id, int rep_id, int ch_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", id);
		map.put("rep_id", rep_id);
		map.put("ch_id", ch_id);
		repMapper.insertUserMetaInvite(map);
	}

	@Override
	public void addBoard(String nickname, int id, int chid1) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", nickname);
		map.put("user_id", id);
		map.put("ch_id", chid1);
		repMapper.insertBoard(map);

	}

	@Override
	public Member getMember(int id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Member m = repMapper.getNameById(id);
		return m;
	}

	@Override
	public void addMember(String email, String pwd, String name) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("pwd", pwd);
		map.put("name", name);
		repMapper.insertMember(map);
	}

	@Override
	public int getRepIdByRepNameUserMeta(String rep_name) {
		repMapper = sqlSession.getMapper(Mapper.class);
		int t = repMapper.selectRepIdByRepNameUserMeta(rep_name);
		return t;
	}

	@Override
	public ArrayList<Integer> getChIdList(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Integer> list = repMapper.selectChIdList(rep_id);
		return list;
	}
	@Override
	public ArrayList<Channel> getChList(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Channel> list = repMapper.selectChList(rep_id);
		return list;
	}
	@Override
	public Member getMember(String email) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Member t = repMapper.selectUserIdByEmail(email);
		return t;
	}
	@Override
	public ArrayList<Integer> getUserList(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Integer> list = repMapper.selectUserList(rep_id);
		return list;
	}
	@Override
	public ArrayList<String> getUserNameList(ArrayList<Integer> userlist) {
		repMapper = sqlSession.getMapper(Mapper.class);			
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", userlist);		
		ArrayList<String> list = repMapper.selectUserNameList(map);		
		return list;
	}

	@Override
	public Repository getRepository(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Repository r = repMapper.selectRepository(rep_id);
		return r;
	}

	@Override
	public ArrayList<String> getRepNameListById(int id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		ArrayList<String> t = repMapper.selectRepList(id);
		return t;
	}

	@Override
	public void setUserMeta2Invite(int id, int rep_id, String nickname) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", id);	
		map.put("rep_id", rep_id);
		map.put("nickname", nickname);
		repMapper.insertUserMeta2Invite(map);
		
	}
	@Override
	public void setUserMeta2Create(int id, int rep_id2, String nickname) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", id);	
		map.put("rep_id", rep_id2);
		map.put("nickname", nickname);
		repMapper.insertUserMeta2Create(map);
	}

	@Override
	public String getNickname(int id, int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("rep_id", rep_id);
		String t = repMapper.selectNickname(map);
		return t;
	}

	@Override
	public Channel getChannel(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Channel c = repMapper.selectChannel(rep_id);
		return c;
	}
	@Override
	public Channel getMaxChannel(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Channel c = repMapper.selectMaxChannel(rep_id);
		return c;
	}

	@Override
	public ArrayList<String> getNicknameList(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);			
		ArrayList<String> t = repMapper.selectNicknameList(rep_id);
		return t;
	}

	@Override
	public ArrayList<Integer> getRepIdList(String search) {
		repMapper = sqlSession.getMapper(Mapper.class);	
		ArrayList<Integer> t = repMapper.selectRepBySearch(search);
		return t;
	}
	@Override
	public ArrayList<String> getRepNameListById(String search) {
		repMapper = sqlSession.getMapper(Mapper.class);	
		ArrayList<String> t = repMapper.selectRepNameBySearch(search);
		return t;
	}

	@Override
	public ArrayList<String> getUserNameListByRepId(ArrayList<Integer> repidlist) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("rep_id", repidlist);
		System.out.println(map);
		ArrayList<String> list = repMapper.selectrepNameList(map);		
		return list;
	}
	@Override
	public ArrayList<UserMeta> getUserMeatList(int id, int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("rep_id", rep_id);	
		ArrayList<UserMeta> list= repMapper.selectUserMetaList(map);
		return list;
	}

	@Override
	public int getUserAdminLevel(int id, int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("rep_id", rep_id);
		int t = repMapper.selectAdminLevel(map);
		return t;
	}

	@Override
	public ArrayList<UserMeta2> getUserMeta2List(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		ArrayList<UserMeta2> um =repMapper.selectUserMeta2(rep_id);
		return um;	
		
	}	
	@Override
	public void deleteChannel(int ch_id) {
		repMapper= sqlSession.getMapper(Mapper.class);
		repMapper.deleteCh(ch_id);		
	}



	@Override
	public void editRep(Repository r) {
		repMapper = sqlSession.getMapper(Mapper.class);
		repMapper.update(r);
	}

	@Override
	public void delRep(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		repMapper.delete(rep_id);
	}

	@Override
	public Member getMemberAll(int id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Member m = repMapper.selectMember(id);
		return m;
	}

	@Override
	public void deleteUserMeta(int id, int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("rep_id", rep_id);
		repMapper.deleteUserMeta(map);
		
	}

	@Override
	public void deleteUserMeta2(int id, int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("rep_id", rep_id);
		repMapper.deleteUserMeta2(map);
	}

	

	

	

	
	

}
