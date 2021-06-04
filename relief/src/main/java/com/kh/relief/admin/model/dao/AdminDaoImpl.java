package com.kh.relief.admin.model.dao;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.relief.admin.model.vo.PageInfo;
import com.kh.relief.admin.model.vo.Qna;
import com.kh.relief.admin.model.vo.Report;
import com.kh.relief.admin.model.vo.Sanctions;
import com.kh.relief.admin.model.vo.Search;
import com.kh.relief.account.model.vo.Account;
import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.admin.model.vo.Chart;
import com.kh.relief.admin.model.vo.Comment;
import com.kh.relief.admin.model.vo.Faq;
import com.kh.relief.admin.model.vo.Notice;

@Repository
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int aCount() {
		return sqlSession.selectOne("adminMapper.aCount");
	}

	@Override
	public int todayAccount() {
		return sqlSession.selectOne("adminMapper.todayAccount");
	}

	@Override
	public int reportCount() {
		return sqlSession.selectOne("adminMapper.reportCount");
	}

	@Override
	public int selectnListCount() {
		return sqlSession.selectOne("adminMapper.selectnListCount");
	}

	@Override
	public List<Notice> selectnList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.selectnList", null, rowBounds);
	}

	@Override
	public int searchNListCount(Search search) {
		return sqlSession.selectOne("adminMapper.searchNListCount", search);
	}

	@Override
	public List<Notice> searchNList(Search search, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.searchNList", search, rowBounds);
	}

	@Override
	public int insertNotice(Notice n) {
		return sqlSession.insert("adminMapper.insertNotice", n);
	}

	@Override
	public Notice selectNotice(int nid) {
		return sqlSession.selectOne("adminMapper.selectNotice", nid);
	}

	@Override
	public int updateNotice(Notice n) {
		return sqlSession.update("adminMapper.updateNotice", n);
	}

	@Override
	public int deleteNotice(int nid) {
		return sqlSession.update("adminMapper.deleteNotice", nid);
	}

	@Override
	public int selectcListCount() {
		return sqlSession.selectOne("adminMapper.selectcListCount");
	}

	@Override
	public List<Category> selectcList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.selectcList", null, rowBounds);
	}

	@Override
	public List<Category> selectcnameList(int cgroup) {
		return sqlSession.selectList("adminMapper.selectcnameList", cgroup);
	}

	@Override
	public int insertCategory(Category c) {
		return sqlSession.insert("adminMapper.insertCategory", c);
	}

	@Override
	public int searchCListCount(Search search) {
		return sqlSession.selectOne("adminMapper.searchCListCount", search);
	}

	@Override
	public List<Category> searchCList(PageInfo pi, Search search) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return sqlSession.selectList("adminMapper.searchCList", search, rowBounds);
	}

	@Override
	public Category selectCategory(int cid) {
		return sqlSession.selectOne("adminMapper.selectCategory", cid);
	}

	@Override
	public int checkCategory(int cid) {
		return sqlSession.selectOne("adminMapper.checkCategory", cid);
	}

	@Override
	public int updateCategory(Category c) {
		return sqlSession.update("adminMapper.updateCategory", c);
	}

	@Override
	public int deleteCateogry(int cid) {
		return sqlSession.update("adminMapper.deleteCategory", cid);
	}

	@Override
	public List<Report> selectrList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.selectrList", null, rowBounds);
	}

	@Override
	public int selectrListCount() {
		return sqlSession.selectOne("adminMapper.selectrListCount");
	}

	@Override
	public int searchRListCount(Search search) {
		return sqlSession.selectOne("adminMapper.searchRListCount", search);
	}

	@Override
	public List<Report> searchRList(Search search, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.searchRList", search , rowBounds);
	}

	@Override
	public Report selectReport(int rpid) {
		return sqlSession.selectOne("adminMapper.selectReport", rpid);
	}

	@Override
	public int insertSanctions(Sanctions s) {
		return sqlSession.insert("adminMapper.insertSanctions", s);
	}

	@Override
	public int banUser(Account a) {
		return sqlSession.update("adminMapper.banUser", a);
	}

	@Override
	public int selectBlockListCount(Date today) {
		return sqlSession.selectOne("adminMapper.selectBlockListCount", today);
	}

	@Override
	public List<Account> blockUser(Date today, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.blockUser", today, rowBounds);
	}

	@Override
	public int selectQnaListCount() {
		return sqlSession.selectOne("adminMapper.selectQnaListCount");
	}

	@Override
	public List<Qna> selectqList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.selectqList", null, rowBounds);
	}

	@Override
	public int unbanUser(List<String> sArr) {
		return sqlSession.update("adminMapper.unbanUser", sArr);
	}

	@Override
	public int searchBListCount(Search search) {
		return sqlSession.selectOne("adminMapper.searchBListCount", search);
	}

	@Override
	public List<Account> searchBList(PageInfo pi, Search search) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.searchBList", search, rowBounds);
	}

	@Override
	public Qna selectQna(int qid) {
		return sqlSession.selectOne("adminMapper.selectQna", qid);
	}

	@Override
	public int updateQna(Qna q) {
		return sqlSession.update("adminMapper.updateQna", q);
	}

	@Override
	public int searchQListCount(Search search) {
		return sqlSession.selectOne("adminMapper.searchQListCount", search);
	}

	@Override
	public List<Qna> searchQList(Search search, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.searchQList", search, rowBounds);
	}

	@Override
	public List<Faq> selectFList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.selectFList", null, rowBounds);
	}

	@Override
	public int selectfListCount() {
		return sqlSession.selectOne("adminMapper.selectfListCount");
	}

	@Override
	public int insertFaq(Faq f) {
		return sqlSession.insert("adminMapper.insertFaq", f);
	}

	@Override
	public int searchFListCount(Search search) {
		return sqlSession.selectOne("adminMapper.searchFListCount", search);
	}

	@Override
	public List<Faq> searchFList(PageInfo pi, Search search) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.searchFList", search, rowBounds);
	}

	@Override
	public Faq selectFaq(int fid) {
		return sqlSession.selectOne("adminMapper.selectFaq", fid);
	}

	@Override
	public int deleteFaq(int fid) {
		return sqlSession.update("adminMapper.deleteFaq", fid);
	}

	@Override
	public int updateFaq(Faq f) {
		return sqlSession.update("adminMapper.updateFaq", f);
	}

	@Override
	public int selectAdListCount() {
		return sqlSession.selectOne("adminMapper.selectAdListCount");
	}

	@Override
	public List<Notice> selectAdList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.selectAdList", null, rowBounds);
	}

	@Override
	public int adUpdate1(List<Integer> iArr1) {
		return sqlSession.update("adminMapper.adUpdate1", iArr1);
	}

	@Override
	public int adUpdate2(List<Integer> iArr2) {
		return sqlSession.update("adminMapper.adUpdate2", iArr2);
	}

	@Override
	public int searchadListCount(Search search) {
		return sqlSession.selectOne("adminMapper.searchadListCount", search);
	}

	@Override
	public List<Notice> searchadList(PageInfo pi, Search search) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("adminMapper.searchadList", search, rowBounds);
	}

	@Override
	public Comment commentDetail(int cmid) {
		return sqlSession.selectOne("adminMapper.commentDetail", cmid);
	}

	@Override
	public List<Chart> chart() {
		return sqlSession.selectList("adminMapper.chart");
	}

	

}
