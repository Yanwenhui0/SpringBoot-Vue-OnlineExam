package com.exam.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.List;

/**
 * @author yanwenhui
 * @date 2020/4/5 22:20
 */
@Data
@TableName("package")
public class QuestionPackage {

    @TableId(type = IdType.UUID)
    String packageId;

    String studentId;

    String questionType;

    String questionId;

    @TableField(exist = false)
    String questionBody;

    @TableField(exist = false)
    String questionAnswer;

    @TableField(exist = false)
    List<String> questionChoose;

}
