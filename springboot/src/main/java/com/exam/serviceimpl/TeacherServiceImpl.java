package com.exam.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.Dto.TeacherSearchDto;
import com.exam.entity.Teacher;
import com.exam.mapper.TeacherMapper;
import com.exam.service.TeacherService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class TeacherServiceImpl implements TeacherService {
    @Autowired
    private TeacherMapper teacherMapper;


    @Override
    public IPage<Teacher> selectByEntity(TeacherSearchDto teacherSearchDto, Page<Teacher> page) {
        Teacher teacher = new Teacher();
        if(StringUtils.isNotBlank(teacherSearchDto.getInstitute())) {
            teacher.setInstitute(teacherSearchDto.getInstitute());
        }
        QueryWrapper<Teacher> queryWrapper = new QueryWrapper<>(teacher);
        if(StringUtils.isNotBlank(teacherSearchDto.getTeacherName())) {
            queryWrapper = queryWrapper.like("teacherName", teacherSearchDto.getTeacherName().trim());
        }
        if(CollectionUtils.isNotEmpty(teacherSearchDto.getTypeList())) {
            queryWrapper = queryWrapper.in("type", teacherSearchDto.getTypeList());
        }
        return teacherMapper.selectPage(page, queryWrapper);
    }

    @Override
    public Map<String, List<String>> initSelect() {
        Map<String, List<String>> data = Maps.newHashMap();
        List<String> instituteList = Lists.newArrayList();
        List<String> typeList = Lists.newArrayList();
        data.put("institute_list", instituteList);
        data.put("type_list", typeList);
        List<Teacher> teachers = teacherMapper.selectList(null);
        for (Teacher teacher : teachers) {
            if(!instituteList.contains(teacher.getInstitute())) {
                instituteList.add(teacher.getInstitute());
            }
            if(!typeList.contains(teacher.getType())) {
                typeList.add(teacher.getType());
            }
        }
        return data;
    }

    @Override
    public IPage<Teacher> findAll(Page<Teacher> page) {
        return teacherMapper.findAll(page);
    }

    @Override
    public List<Teacher> findAll() {
        return teacherMapper.findAll();
    }

    @Override
    public Teacher findById(Integer teacherId) {
        return teacherMapper.findById(teacherId);
    }

    @Override
    public int deleteById(Integer teacherId) {
        return teacherMapper.deleteById(teacherId);
    }

    @Override
    public int update(Teacher teacher) {
        return teacherMapper.update(teacher);
    }

    @Override
    public int add(Teacher teacher) {
        return teacherMapper.add(teacher);
    }
}
