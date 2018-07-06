package com.kitri.project.post;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import vo.Channel;
import vo.Member;
import vo.Post;
import vo.Repository;

@Component("postService")
public class ServiceImpl implements Service {
	@Resource(name="sqlSession")
	private SqlSession sqlSession;
	private Mapper mapper;
	
	@Override
	public void write(Post post) {
		mapper = sqlSession.getMapper(Mapper.class);
		if (post.getFile_thumbnail() == null) {
			post.setFile_thumbnail("x");
		}
		mapper.insert(post);
	}

	@Override
	public ArrayList<Post> show(int page, int cn) {
		int endpage = 0;
		if (page == 1) {
			page = 1;
			endpage = 10; 
		} else {
			endpage = page * 10; 
			page = (page -1) *10 +1;
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startpage", page);
		map.put("endPage", endpage);
		map.put("cn", cn);
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Post> list = mapper.selectAll(map);
		return list;
	}

	@Override
	public ArrayList<Post> showMore(int page, int cn) {
		int endpage = 0;
		if (page == 1) {
			page = 1;
			endpage = 10; 
		} else {
			endpage = page * 10; 
			page = (page -1) *10;
		}
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startpage", page);
		map.put("endPage", endpage);
		map.put("cn", cn);
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Post> list = mapper.selectAllMore(map);
		return list;
	}
	
	@Override
	public ArrayList<Post> getSearchBoard(int page, int rep_id,String search) {
		int endpage = 0;
		if (page == 1) {
			page = 1;
			endpage = 10; 
		} else {
			endpage = page * 10; 
			page = (page -1) *10 +1;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startpage", page);
		map.put("endPage", endpage);
		map.put("rep_id", rep_id);
		map.put("search", search);		
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Post> list = mapper.selectSearchResult(map);
		return list;
	}
	
	@Override
	public ArrayList<Post> getSearchBoardMore(int page, int rep_id,String search) {
		int endpage = 0;
		if (page == 1) {
			page = 1;
			endpage = 10; 
		} else {
			endpage = page * 10; 
			page = (page -1) *10 ;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startpage", page);
		map.put("endPage", endpage);
		map.put("rep_id", rep_id);
		map.put("search", search);		
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Post> list = mapper.selectSearchResultMore(map);
		return list;
	}
	@Override
	public Channel getChannel(int cn) {
		mapper = sqlSession.getMapper(Mapper.class);
		Channel c = mapper.selectChannel(cn);
		return c;
	}

	@Override
	public void change(String content, int post_id) {
		mapper = sqlSession.getMapper(Mapper.class);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("content", content);
		map.put("post_id", post_id);
		mapper.update(map);
	}

	@Override
	public void delete(int post_id) {
		mapper = sqlSession.getMapper(Mapper.class);
		mapper.delete(post_id);
	}

	@Override
	public ArrayList<String> getNicknameList(int rep_id) {
		mapper = sqlSession.getMapper(Mapper.class);			
		ArrayList<String> t = mapper.selectNicknameList(rep_id);
		return t;
	}

	@Override
	public ArrayList<Channel> getChList(int rep_id) {
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Channel> list = mapper.selectChList(rep_id);
		return list;
	}

	@Override
	public String getNickname(int id,int rep_id) {
		mapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("rep_id", rep_id);
		String s = mapper.selectNickname(map);
		return s;
	}

	@Override
	public Member getMember(int id) {
		mapper = sqlSession.getMapper(Mapper.class);
		Member m = mapper.selectMember(id);
		return m;
	}

	@Override
	public Repository getRepository(int rep_id) {
		mapper = sqlSession.getMapper(Mapper.class);
		Repository r = mapper.selectRepository(rep_id);
		return r;
	}

	@Override
	public int getFirstChannelId(int rep_id) {
		mapper = sqlSession.getMapper(Mapper.class);
		int i = mapper.selectFirstChannelId(rep_id);
		return i;
	}

	@Override
	public ArrayList<String> getRepNameListById(int id) {
		mapper = sqlSession.getMapper(Mapper.class);
		 ArrayList<String> t = mapper.selectRepList(id);
		return t;
	}

}
