package com.exam.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.Dto.TeacherSearchDto;
import com.exam.entity.Teacher;

import java.util.List;
import java.util.Map;

public interface TeacherService {

    IPage<Teacher> selectByEntity(TeacherSearchDto teacherSearchDto, Page<Teacher> page);

    Map<String, List<String>> initSelect();

    IPage<Teacher> findAll(Page<Teacher> page);

    public List<Teacher> findAll();

    public Teacher findById(Integer teacherId);

    public int deleteById(Integer teacherId);

    public int update(Teacher teacher);

    public int add(Teacher teacher);

    Integer updatePassword(String teacherId, String oldPassword, String password);
}
