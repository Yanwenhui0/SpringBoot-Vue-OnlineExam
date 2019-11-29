package com.exam.Dto;

import lombok.Data;

import java.util.List;

/**
 * @Author yanwenhui
 * @Date 2019/11/28 17:14
 **/
@Data
public class StudentSearchDto {

    String studentName;
    List<String> gradeList;
    String institute;
    String major;

}
