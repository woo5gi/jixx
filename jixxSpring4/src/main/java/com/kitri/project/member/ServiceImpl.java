package com.kitri.project.member;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import com.kitri.project.repository.MailHandler;

import vo.Member;

@Component("memService")
public class ServiceImpl implements Service{
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	private Mapper memberMapper;
	private MailHandler mailHandler;
	
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
	public void setTempkey(int ran2,int id) {
		memberMapper = sqlSession.getMapper(Mapper.class);
		Map<String, Integer> map = new HashMap<String, Integer>(); 
		map.put("tempkey", ran2);
		map.put("id", id);		
		memberMapper.setTempkey(map);		
		
	}
	




}

