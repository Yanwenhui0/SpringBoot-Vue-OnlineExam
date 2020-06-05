package com.exam.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class Teacher {

    private Integer teacherId;

    private String teacherName;

    private String institute;

    private String sex;

    private String tel;

    private String email;

    private String pwd;

    private String cardId;

    private String type;

    private String role;
}
