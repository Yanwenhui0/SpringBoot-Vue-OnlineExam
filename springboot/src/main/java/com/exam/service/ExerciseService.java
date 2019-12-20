package com.exam.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.exam.entity.Exercise;

import java.util.List;

/**
 * @Author yanwenhui
 * @Date 2019/12/10 10:11
 **/
public interface ExerciseService {

    int save(Exercise exercise);

    int delete(int id);

    IPage<Exercise> getAll(int page, int limit);

    Exercise getOne(int id);
}
