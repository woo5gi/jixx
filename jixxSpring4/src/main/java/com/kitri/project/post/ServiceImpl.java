package com.kitri.project.post;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import vo.Channel;
import vo.Post;

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
			endpage = 5; 
		} else {
			page *= 5;
			endpage = page + 4; 
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
	public Channel getChannel(int cn) {
		mapper = sqlSession.getMapper(Mapper.class);
		Channel c = mapper.selectChannel(cn);
		return c;
	}

	@Override
	public Post change(Post post) {
		return null;
	}

	@Override
	public void delete(int post_id) {
		mapper = sqlSession.getMapper(Mapper.class);
		mapper.delete(post_id);
	}

	
	
}
