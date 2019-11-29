package com.exam;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.Dto.StudentSearchDto;
import com.exam.service.StudentService;
import com.google.common.collect.Lists;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ExamsystemApplicationTests {

    @Autowired
    StudentService studentService;

    @Test
    public void contextLoads() {
        StudentSearchDto studentSearchDto = new StudentSearchDto();
        studentSearchDto.setMajor("计算机科学与技术");
        studentSearchDto.setGradeList(Lists.newArrayList("2015"));
        System.out.println(studentService.findByEntity(studentSearchDto, new Page<>(1,10)));
    }

}

