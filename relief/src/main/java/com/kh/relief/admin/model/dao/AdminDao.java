package com.kh.relief.admin.model.dao;

import java.sql.Date;
import java.util.List;

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

public interface AdminDao {

	int aCount();

	int todayAccount();

	int reportCount();

	int selectnListCount();

	List<Notice> selectnList(PageInfo pi);

	int searchNListCount(Search search);

	List<Notice> searchNList(Search search, PageInfo pi);

	int insertNotice(Notice n);

	Notice selectNotice(int nid);

	int updateNotice(Notice n);

	int deleteNotice(int nid);

	int selectcListCount();

	List<Category> selectcList(PageInfo pi);

	List<Category> selectcnameList(int cgroup);

	int insertCategory(Category c);

	int searchCListCount(Search search);

	List<Category> searchCList(PageInfo pi, Search search);

	Category selectCategory(int cid);

	int checkCategory(int cid);

	int updateCategory(Category c);

	int deleteCateogry(int cid);

	List<Report> selectrList(PageInfo pi);

	int selectrListCount();

	int searchRListCount(Search search);

	List<Report> searchRList(Search search, PageInfo pi);

	Report selectReport(int rpid);

	int insertSanctions(Sanctions s);

	int banUser(Account a);

	int selectBlockListCount(Date today);

	List<Account> blockUser(Date today, PageInfo pi);

	int selectQnaListCount();

	List<Qna> selectqList(PageInfo pi);

	int unbanUser(List<String> sArr);

	int searchBListCount(Search search);

	List<Account> searchBList(PageInfo pi, Search search);

	Qna selectQna(int qid);

	int updateQna(Qna q);

	int searchQListCount(Search search);

	List<Qna> searchQList(Search search, PageInfo pi);

	List<Faq> selectFList(PageInfo pi);

	int selectfListCount();

	int insertFaq(Faq f);

	int searchFListCount(Search search);

	List<Faq> searchFList(PageInfo pi, Search search);

	Faq selectFaq(int fid);

	int deleteFaq(int fid);

	int updateFaq(Faq f);

	int selectAdListCount();

	List<Notice> selectAdList(PageInfo pi);

	int adUpdate1(List<Integer> iArr1);

	int adUpdate2(List<Integer> iArr2);

	int searchadListCount(Search search);

	List<Notice> searchadList(PageInfo pi, Search search);

	Comment commentDetail(int cmid);

	List<Chart> chart();


}
