package com.exam.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.exam.vo.AnswerVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;


@Mapper
public interface AnswerMapper extends BaseMapper<AnswerVO> {
    @Select("select questionId, question, subject, score,level,collect, \"选择题\" as type from multi_question " +
            "union select questionId, question, subject, score,level,collect, \"判断题\" as type  from judge_question " +
            "union select questionId, question, subject, score,level,collect, \"填空题\" as type from fill_question")
    IPage<AnswerVO> findAll(Page page);

    @Select("select questionId, question, subject, score,level,collect, \"选择题\" as type from multi_question where subject=#{subject} " +
            "union select questionId, question, subject, score,level,collect, \"判断题\" as type  from judge_question where subject=#{subject} " +
            "union select questionId, question, subject, score,level,collect, \"填空题\" as type from fill_question where subject=#{subject}")
    IPage<AnswerVO> findAllBySubject(Page page, String subject);
}
