package com.kh.relief.notice.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.common.PageInfo;
import com.kh.relief.notice.model.vo.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int selectListCount() {
		return sqlSession.selectOne("noticeMapper.selectListCount");
	}

	@Override
	public List<Notice> selectList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("noticeMapper.selectList", null, rowBounds);
	}

	@Override
	public int insertNotice(Notice n) {
		return sqlSession.insert("noticeMapper.insertNotice", n);
	}

	@Override
	public Notice selectNotice(int notice_id) {
		return sqlSession.selectOne("noticeMapper.selectNotice", notice_id);
	}

	@Override
	public int updateNotice(Notice n) {
		return sqlSession.update("noticeMapper.updateNotice", n);
	}

	@Override
	public void updateReadCount(int notice_id) {
		sqlSession.update("noticeMapper.updateReadCount", notice_id);
	}

	@Override
	public int deleteNotice(int notice_id) {
		return sqlSession.update("noticeMapper.deleteNotice", notice_id);
	}
}
