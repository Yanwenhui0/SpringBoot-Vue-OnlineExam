package com.exam.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import lombok.Data;
import org.apache.ibatis.type.JdbcType;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * @Author yanwenhui
 * @Date 2020/4/15 9:39
 **/
@Data
public class Note {

    @TableId(type = IdType.UUID)
    String noteId;

    String studentId;

    @NotBlank
    String title;

    String content;

    @TableField(fill = FieldFill.INSERT)
    Date createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    Date updateTime;
}
