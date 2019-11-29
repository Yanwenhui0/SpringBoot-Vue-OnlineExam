package com.exam.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.Dto.StudentSearchDto;
import com.exam.entity.Student;

import java.util.List;
import java.util.Map;

public interface StudentService {

    IPage<Student> findByEntity(StudentSearchDto studentSearchDto, Page<Student> page);

    Map<String, List<String>> initSelect();

    IPage<Student> findAll(Page<Student> page);

    Student findById(Integer studentId);

    int deleteById(Integer studentId);

    int update(Student student);

    int updatePwd(Student student);

    int add(Student student);
}
