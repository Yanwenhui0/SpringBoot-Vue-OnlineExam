package com.exam.entity;

import lombok.Data;

//填空题实体类
@Data
public class FillQuestion {
    private Integer questionId;

    private String question;

    private String answer;

    private Integer score;

    private String level;

    private String subject;

    private String analysis; //题目解析

    private Integer collect;
}
