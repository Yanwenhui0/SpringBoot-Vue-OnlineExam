package com.exam.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

//填空题实体类
@Data
public class FillQuestion {
    @TableId
    private Integer questionId;

    private String question;

    private String answer;

    private Integer score;

    private String level;

    private String subject;

    private String analysis; //题目解析

    private Integer collect;

    private Integer ok;

    private Integer total;

    @TableField(exist = false)
    private String scale;
}
