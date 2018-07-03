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
	public Repository selectRepByName(Repository r) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Repository r2 = repMapper.getRepositoryByName(r);
		return r2;
	}

	@Override
	public Repository getRepId(Repository r) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Repository r2 = repMapper.getRepIdByRepName(r);
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
	public Channel getChId(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Channel ch = repMapper.getChByRepId2(rep_id);
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
	public ArrayList<Integer> getChList(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Integer> list = repMapper.selectChList(rep_id);
		return list;
	}
	@Override
	public ArrayList<String> getChNameList(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		ArrayList<String> list = repMapper.selectChNameList(rep_id);
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
	public Repository selectRepByName(int rep_id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Repository r = repMapper.selectRepName(rep_id);
		return r;
	}

	@Override
	public ArrayList<String> getRepNameListById(int id) {
		repMapper = sqlSession.getMapper(Mapper.class);
		ArrayList<String> t = repMapper.selectRepList(id);
		return t;
	}

	@Override
	public void setUserMeta2(int id, int rep_id, String nickname) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id", id);	
		map.put("rep_id", rep_id);
		map.put("nickname", nickname);
		repMapper.insertUserMeta2(map);
		
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
	public Channel getChannel(int cn) {
		repMapper = sqlSession.getMapper(Mapper.class);
		Channel c = repMapper.selectChannel(cn);
		return c;
	}

	


	

	
	

	

	

	
	
}
