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
import vo.UserMeta;

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
		int[] pages = pageTuning(page);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startpage", pages[0]);
		map.put("endPage", pages[1]);
		map.put("cn", cn);
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Post> list = mapper.selectAll(map);
		return list;
	}

	@Override
	public ArrayList<Post> showMore(int page, int cn) {
		int[] pages = pageTuning(page);
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("startpage", pages[0]);
		map.put("endPage", pages[1]);
		map.put("cn", cn);
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Post> list = mapper.selectAllMore(map);
		return list;
	}
	
	@Override
	public ArrayList<Post> getSearchBoard(int page, int rep_id,String search) {
		int[] pages = pageTuning(page);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startpage", pages[0]);
		map.put("endPage", pages[1]);
		map.put("rep_id", rep_id);
		map.put("search", search);		
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Post> list = mapper.selectSearchResult(map);
		return list;
	}
	
	@Override
	public ArrayList<Post> getSearchBoardMore(int page, int rep_id,String search) {
		int[] pages = pageTuning(page);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startpage", pages[0]);
		map.put("endPage", pages[1]);
		map.put("rep_id", rep_id);
		map.put("search", search);		
		mapper = sqlSession.getMapper(Mapper.class);
		ArrayList<Post> list = mapper.selectSearchResultMore(map);
		return list;
	}
	
	public int[] pageTuning(int page) {
		int endpage = 0;
		if (page == 1) {
			page = 1;
			endpage = 10; 
		} else {
			endpage = page * 10; 
			page = (page -1) *10 ;
		}
		int[] pages = {page,endpage};
		return pages;
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

	@Override
	public ArrayList<Post> getRepost(ArrayList<Post> list) {
		mapper = sqlSession.getMapper(Mapper.class);			
		ArrayList<Post> repost = mapper.selectRepost(list);
		return repost;
	}

	public int getUserAdminLevel(int id, int rep_id) {
		mapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("rep_id",rep_id);
		int t = mapper.selectUserAdminLevel(map);
		return t;
	}


	@Override
	public ArrayList<Integer> getMemberId(int cn,int id) {
		mapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("cn", cn);
		map.put("id", id);
		ArrayList<Integer> t = mapper.selectMemberId(map);
		return t;
	}

	@Override
	public ArrayList<String> getMemberEmail(ArrayList<Integer> idlist) {
		mapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("idlist", idlist);
		ArrayList<String> t = mapper.selectMemberEmail(map);
		return t;
	}

	@Override
	public ArrayList<Integer> getAlarmType(int id, int rep_id,  int[] chidlist) {
		mapper = sqlSession.getMapper(Mapper.class);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("id", id);
		map.put("rep_id", rep_id);
		map.put("cn", chidlist);
		ArrayList<Integer> t = mapper.selectAlarmType(map);
		return t;
	}
}
