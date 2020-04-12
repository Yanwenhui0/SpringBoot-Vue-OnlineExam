package com.exam.serviceimpl;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.entity.Exercise;
import com.exam.mapper.ExerciseMapper;
import com.exam.service.ExerciseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author yanwenhui
 * @Date 2019/12/10 10:11
 **/
@Service
public class ExerciseServiceImpl implements ExerciseService {

    @Autowired
    private ExerciseMapper exerciseMapper;

    @Override
    public int save(Exercise exercise) {
        return exerciseMapper.insert(exercise);
    }

    @Override
    public int delete(int id) {
        return exerciseMapper.deleteById(id);
    }

    @Override
    public IPage<Exercise> getAll(int studentId, int page, int limit) {
        IPage<Exercise> exercisePage = new Page<>(page, limit);
        QueryWrapper<Exercise> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("studentId", studentId);
        return exerciseMapper.selectPage(exercisePage, queryWrapper);
    }

    @Override
    public Exercise getOne(int id) {
        Exercise exercise = exerciseMapper.selectById(id);
        exercise.setMultiNumber(exercise.getMulti().split(",").length);
        exercise.setFillNumber(exercise.getFill().split(",").length);
        exercise.setJudgeNumber(exercise.getJudge().split(",").length);
        return exercise;
    }
}
