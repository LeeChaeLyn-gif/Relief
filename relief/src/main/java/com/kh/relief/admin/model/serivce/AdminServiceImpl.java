package com.kh.relief.admin.model.serivce;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.relief.account.model.vo.Account;
import com.kh.relief.admin.model.dao.AdminDao;
import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.admin.model.vo.Chart;
import com.kh.relief.admin.model.vo.Faq;
import com.kh.relief.admin.model.vo.Notice;
import com.kh.relief.admin.model.vo.PageInfo;
import com.kh.relief.admin.model.vo.Qna;
import com.kh.relief.admin.model.vo.Report;
import com.kh.relief.admin.model.vo.Sanctions;
import com.kh.relief.admin.model.vo.Search;
import com.kh.relief.board.model.vo.Reply;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired
	private AdminDao aDao;
	
	@Override
	public int aCount() {
		return aDao.aCount();
	}

	@Override
	public int todayAccount() {
		return aDao.todayAccount();
	}

	@Override
	public int reportCount() {
		return aDao.reportCount();
	}

	@Override
	public int selectnListCount() {
		return aDao.selectnListCount();
	}

	@Override
	public List<Notice> selectnList(PageInfo pi) {
		return aDao.selectnList(pi);
	}

	@Override
	public int searchNListCount(Search search) {
		return aDao.searchNListCount(search);
	}

	@Override
	public List<Notice> searchNList(Search search, PageInfo pi) {
		return aDao.searchNList(search, pi);
	}

	@Override
	public int insertNotice(Notice n) {
		return aDao.insertNotice(n);
	}

	@Override
	public Notice selectNotice(int nid) {
		return aDao.selectNotice(nid);
	}

	@Override
	public int updateNotice(Notice n) {
		return aDao.updateNotice(n);
	}

	@Override
	public int deleteNotice(int nid) {
		return aDao.deleteNotice(nid);
	}

	@Override
	public int selectcListCount() {
		return aDao.selectcListCount();
	}

	@Override
	public List<Category> selectcList(PageInfo pi) {
		return aDao.selectcList(pi);
	}

	@Override
	public List<Category> selectcnameList(int cgroup) {
		return aDao.selectcnameList(cgroup);
	}

	@Override
	public int insertCategory(Category c) {
		return aDao.insertCategory(c);
	}

	@Override
	public int searchCListCount(Search search) {
		return aDao.searchCListCount(search);
	}

	@Override
	public List<Category> searchCList(PageInfo pi, Search search) {
		return aDao.searchCList(pi, search);
	}

	@Override
	public Category selectCategory(int cid) {
		return aDao.selectCategory(cid);
	}

	@Override
	public int checkCategory(int cid) {
		return aDao.checkCategory(cid);
	}

	@Override
	public int updateCategory(Category c) {
		return aDao.updateCategory(c);
	}

	@Override
	public int deleteCategory(int cid) {
		return aDao.deleteCateogry(cid);
	}

	@Override
	public List<Report> selectrList(PageInfo pi) {
		return aDao.selectrList(pi);
	}

	@Override
	public int selectrListCount() {
		return aDao.selectrListCount();
	}

	@Override
	public int searchRListCount(Search search) {
		return aDao.searchRListCount(search);
	}

	@Override
	public List<Report> searchRList(PageInfo pi, Search search) {
		return aDao.searchRList(search, pi);
	}

	@Override
	public Report selectReport(int rpid) {
		return aDao.selectReport(rpid);
	}

	@Override
	public int insertSanctions(Sanctions s) {
		return aDao.insertSanctions(s);
	}

	@Override
	public int banUser(Account a) {
		return aDao.banUser(a);
	}

	@Override
	public int selectBlockListCount(Date today) {
		return aDao.selectBlockListCount(today);
	}

	@Override
	public List<Account> blockUser(Date today, PageInfo pi) {
		return aDao.blockUser(today, pi);
	}

	@Override
	public int selectQnaListCount() {
		return aDao.selectQnaListCount();
	}

	@Override
	public List<Qna> selectqList(PageInfo pi) {
		return aDao.selectqList(pi);
	}

	@Override
	public int unbanUser(List<String> sArr) {
		return aDao.unbanUser(sArr);
	}

	@Override
	public int searchBListCount(Search search) {
		return aDao.searchBListCount(search);
	}

	@Override
	public List<Account> searchBList(PageInfo pi, Search search) {
		return aDao.searchBList(pi ,search);
	}

	@Override
	public Qna selectQna(int qid) {
		return aDao.selectQna(qid);
	}

	@Override
	public int updateQna(Qna q) {
		return aDao.updateQna(q);
	}

	@Override
	public int searchQListCount(Search search) {
		return aDao.searchQListCount(search);
	}

	@Override
	public List<Qna> searchQList(Search search, PageInfo pi) {
		return aDao.searchQList(search, pi);
	}

	@Override
	public List<Faq> selectfList(PageInfo pi) {
		return aDao.selectFList(pi);
	}

	@Override
	public int selectfListCount() {
		return aDao.selectfListCount();
	}

	@Override
	public int insertFaq(Faq f) {
		return aDao.insertFaq(f);
	}

	@Override
	public int searchFListCount(Search search) {
		return aDao.searchFListCount(search);
	}

	@Override
	public List<Faq> searchFList(Search search, PageInfo pi) {
		return aDao.searchFList(pi, search);
	}

	@Override
	public Faq selectFaq(int fid) {
		return aDao.selectFaq(fid);
	}

	@Override
	public int deleteFaq(int fid) {
		return aDao.deleteFaq(fid);
	}

	@Override
	public int updateFaq(Faq f) {
		return aDao.updateFaq(f);
	}

	@Override
	public int selectAdListCount() {
		return aDao.selectAdListCount();
	}

	@Override
	public List<Notice> selectAdList(PageInfo pi) {
		return aDao.selectAdList(pi);
	}

	@Override
	public int adUpdate1(List<Integer> iArr1) {
		return aDao.adUpdate1(iArr1);
	}

	@Override
	public int adUpdate2(List<Integer> iArr2) {
		return aDao.adUpdate2(iArr2);
	}

	@Override
	public int searchadListCount(Search search) {
		return aDao.searchadListCount(search);
	}

	@Override
	public List<Notice> searchadList(PageInfo pi, Search search) {
		return aDao.searchadList(pi, search);
	}

	@Override
	public Reply commentDetail(int rid) {
		return aDao.commentDetail(rid);
	}

	@Override
	public List<Chart> chart() {
		return aDao.chart();
	}

	

}
