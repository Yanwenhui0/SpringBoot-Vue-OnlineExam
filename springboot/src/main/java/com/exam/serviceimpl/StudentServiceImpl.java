package com.exam.serviceimpl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.Dto.StudentSearchDto;
import com.exam.entity.Student;
import com.exam.mapper.StudentMapper;
import com.exam.service.StudentService;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.collections4.ListUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;


    @Override
    public IPage<Student> findByEntity(StudentSearchDto studentSearchDto, Page<Student> page) {
        Student student = new Student();
        if(StringUtils.isNotBlank(studentSearchDto.getInstitute())) {
            student.setInstitute(studentSearchDto.getInstitute());
        }
        if(StringUtils.isNotBlank(studentSearchDto.getMajor())) {
            student.setMajor(studentSearchDto.getMajor());
        }
        QueryWrapper<Student> queryWrapper = new QueryWrapper<>(student);
        if(StringUtils.isNotBlank(studentSearchDto.getStudentName())) {
            queryWrapper = queryWrapper.like("studentName", studentSearchDto.getStudentName());
        }
        if(CollectionUtils.isNotEmpty(studentSearchDto.getGradeList())) {
            queryWrapper = queryWrapper.in("grade", studentSearchDto.getGradeList());
        }
        return studentMapper.selectPage(page, queryWrapper);
    }

    @Override
    public Map<String, List<String>> initSelect() {
        Map <String, List<String>> data = Maps.newHashMap();
        List<String> instituteList = Lists.newArrayList();
        List<String> majorList = Lists.newArrayList();
        List<String> gradeList = Lists.newArrayList();
        data.put("institute_list", instituteList);
        data.put("major_list", majorList);
        data.put("grade_list", gradeList);
        List<Student> students = studentMapper.selectList(new QueryWrapper<Student>(null).select("institute", "major", "grade"));
        for (Student student : students) {
            if(!instituteList.contains(student.getInstitute())) {
                instituteList.add(student.getInstitute());
            }
            if(!majorList.contains(student.getMajor())) {
                majorList.add(student.getMajor());
            }
            if(!gradeList.contains(student.getGrade())) {
                gradeList.add(student.getGrade());
            }
        }
        return data;
    }

    @Override
    public IPage<Student> findAll(Page<Student> page) {
        return studentMapper.findAll(page);
    }

    @Override
    public Student findById(Integer studentId) {
        return studentMapper.findById(studentId);
    }

    @Override
    public int deleteById(Integer studentId) {
        return studentMapper.deleteById(studentId);
    }

    @Override
    public int update(Student student) {
        return studentMapper.update(student);
    }

    @Override
    public int updatePwd(Student student) {
        return studentMapper.updatePwd(student);
    }

    @Override
    public int add(Student student) {
        return studentMapper.add(student);
    }
}
