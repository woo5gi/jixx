package com.kitri.project.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import vo.Member;
import vo.Repository;

@Component("memService")
public class ServiceImpl implements Service{
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	private Mapper memberMapper;	
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	@Override
	public void addMember(Member m) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		memberMapper.insert(m);		
	}
	@Override
	public Member getMemberId(int id) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		Member m = memberMapper.select(id);
		return m;
	}
	@Override
	public Member getMemberEmail(String email) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		Member m = memberMapper.selecteMail(email);
		return m;
	}
	@Override
	public void editMember(Member m) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		memberMapper.update(m);		
	}

	@Override
	public void delMember(int id) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		memberMapper.delete(id);		
	}
	@Override
	public void verifyMember(Member m) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		memberMapper.verify(m);				
	}
	@Override
	public void verifyMemberByEmail(String email) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		memberMapper.verifyByEmail(email);			
	}
	@Override
	public void setTempkey(int ran2,int id) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("tempkey", ran2);
		map.put("id", id);
		System.out.println(ran2 +""+ id);
		memberMapper.setTempkey(map);		
		
	}
	
	@Override
	public void setTempkey(int ran2, String email) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("tempkey", ran2);
		map.put("email", email);
		System.out.println("tempkey:"+ran2+"email:"+email);
		memberMapper.setTempkeyByEmail(map);		
	}
	@Override
	public int selectTempKey(String email) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		int t = memberMapper.selectTempKey(email);
		return t;
		
	}
	@Override
	public void setNewPass(Member m) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		memberMapper.setNewPass(m);		
	}
	@Override
	public List<Repository> getRepNameListById(int id) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		List<Repository> t = memberMapper.selectRepList(id);
		return t;
	}

	

	




}

