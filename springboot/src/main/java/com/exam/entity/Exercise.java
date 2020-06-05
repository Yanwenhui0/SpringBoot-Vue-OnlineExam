package com.exam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.util.Date;

/**
 * @Author yanwenhui
 * @Date 2019/12/9 14:06
 **/
@Data
public class Exercise {

    @TableId(type = IdType.AUTO)
    private Integer exerciseId;
    private Integer studentId;
    private String name;
    private String subject;
    private String remark;
    private Integer score;
    private Integer total;
    private String multi;
    private String fill;
    private String judge;
    private Date created;

    @TableField(exist = false)
    private Integer multiNumber;
    @TableField(exist = false)
    private Integer fillNumber;
    @TableField(exist = false)
    private Integer judgeNumber;

}
