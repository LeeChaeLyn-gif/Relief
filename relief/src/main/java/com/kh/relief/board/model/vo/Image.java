package com.kh.relief.board.model.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Image {
   private int iid;
   private int bid;
   private String fileName;
   private String renameFileName;
   private List<Image> iList;
}
