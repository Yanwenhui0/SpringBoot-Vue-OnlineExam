package com.exam.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

// 选择题实体
@Data
public class MultiQuestion {
    @TableId
    private Integer questionId;

    private String subject;

    private String answerA;

    private String answerB;

    private String answerC;

    private String answerD;

    private String question;

    private String level;

    private String rightAnswer;

    private String analysis; //题目解析

    private Integer score;

    private Integer collect;

    private Integer ok;

    private Integer total;

    @TableField(exist = false)
    private String scale;
}
