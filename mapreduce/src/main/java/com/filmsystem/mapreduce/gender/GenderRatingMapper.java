package com.filmsystem.mapreduce.gender;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

/**
 * 性别维度评分分析Mapper
 * 输入：用户评分数据 (userId,movieId,rating,movieTitle,gender)
 * 输出：(gender:movieId:movieTitle, rating)
 * 
 * @author FilmSystem
 */
public class GenderRatingMapper extends Mapper<LongWritable, Text, Text, DoubleWritable> {
    
    private Text genderMovieInfo = new Text();
    private DoubleWritable rating = new DoubleWritable();
    
    @Override
    public void map(LongWritable key, Text value, Context context) 
            throws IOException, InterruptedException {
        
        // 解析输入数据：userId,movieId,rating,movieTitle,gender
        String line = value.toString().trim();
        if (line.isEmpty()) {
            return;
        }
        
        String[] fields = line.split(",");
        if (fields.length >= 5) {
            String movieId = fields[1].trim();
            String ratingValue = fields[2].trim();
            String movieTitle = fields[3].trim();
            String gender = fields[4].trim();
            
            try {
                double ratingDouble = Double.parseDouble(ratingValue);
                
                // 输出：(gender:movieId:movieTitle, rating)
                genderMovieInfo.set(gender + ":" + movieId + ":" + movieTitle);
                rating.set(ratingDouble);
                context.write(genderMovieInfo, rating);
            } catch (NumberFormatException e) {
                // 忽略无效的评分数据
            }
        }
    }
}