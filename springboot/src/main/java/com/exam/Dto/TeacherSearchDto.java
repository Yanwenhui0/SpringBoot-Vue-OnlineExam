package com.exam.Dto;

import lombok.Data;

import java.util.List;

/**
 * @Author yanwenhui
 * @Date 2019/11/29 11:09
 **/
@Data
public class TeacherSearchDto {

    private String teacherName;

    private String institute;

    private List<String> typeList;

}
