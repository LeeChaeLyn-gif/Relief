package com.kh.relief.board.model.service;

import java.util.List;

import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.admin.model.vo.Report;
import com.kh.relief.notice.model.vo.Notice;
import com.kh.relief.review.model.vo.Review;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.BoardImage;
import com.kh.relief.board.model.vo.CategoryBoard;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.PageInfo;
import com.kh.relief.board.model.vo.Reply;
import com.kh.relief.board.model.vo.SearchBoard;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.Search;
import com.kh.relief.board.model.vo.Wish;

public interface BoardService {

	// 오늘의 추천 상품
	List<Board> selectTodayList();

	// 상품 조회
	Board selectBoard(int board_id, boolean flag);

	// 이미지
	Image selectImage(int board_id);

	// 이미지 여러개
	List<Image> selectImageList(int board_id);

	// 찜목록 추가
	int insertWish(Wish w);

	// 찜목록 확인
	Wish selectWish(Wish w);

	// 찜목록 개수
	int wishCount(String aid);
	
	int selectbListCount(SearchBoard sb);

	List<Board> selectbList(SearchBoard sb, PageInfo pi);

	Image selectiList(int board_id);

	List<Board> descbList(SearchBoard sb, PageInfo pi);

	List<Board> ascbList(SearchBoard sb, PageInfo pi);

	List<Category> selectcList();

	Category selectCategory1(int cid);

	List<Category> selectcListFromCid2(int cid);

	List<Category> selectcListFromiList(List<Integer> iList);

	int selectbListFromCategoryCount(CategoryBoard cb);

	List<Board> selectbListFromCategory(CategoryBoard cb, PageInfo pi);

	int selectbListFromCategoryCount2(CategoryBoard cb);

	List<Board> selectbListFromCategory2(CategoryBoard cb, PageInfo pi);
//	// 찜목록
//	List<Wish> selectWlist();
	// 카테고리 1차만 가져오기
	List<Category> selectCategory();
	// 카테고리 2차만 가져오기
	List<Category> selectCategory2(int cid);

	int insertBoard(Board b);

	int insertImage(BoardImage bi);

	int selectbId();

	int reportUser(Report r);

	int reportUser2(Report r);
	
	int reportUser3(Report r);

	List<Notice> selectadList();

	List<Review> selectrList(String account_id);

	List<Reply> insertReply(Reply r);

	List<Reply> selectReplyList(int board_id);
	
	List<Reply> insertReply2(Reply r);

	// 대댓글 가져오기
	List<Reply> selectReply2List(int board_id);

	int nLoginListCount(String searchValue);

	List<Board> nLoginList(PageInfo pi, String searchValue);

	int insertThistory(Board board);

	int insertImage2(BoardImage bi2);

	int deleteImage(int iid);

	int updateBoard(Board b);

}
