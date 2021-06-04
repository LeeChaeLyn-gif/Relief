package com.kh.relief.board.model.dao;

import java.util.List;

import com.kh.relief.admin.model.vo.Category;
import com.kh.relief.board.model.vo.Board;
import com.kh.relief.board.model.vo.CategoryBoard;
import com.kh.relief.board.model.vo.Image;
import com.kh.relief.board.model.vo.PageInfo;
import com.kh.relief.board.model.vo.SearchBoard;

public interface BoardDao {

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

}
