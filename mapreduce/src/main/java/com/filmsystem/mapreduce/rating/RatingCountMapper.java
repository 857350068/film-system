package com.filmsystem.mapreduce.rating;

import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

/**
 * 评价次数统计Mapper
 * 输入：用户评分数据 (userId,movieId,rating,movieTitle)
 * 输出：(movieId:movieTitle, 1)
 * 
 * @author FilmSystem
 */
public class RatingCountMapper extends Mapper<LongWritable, Text, Text, IntWritable> {
    
    private final static IntWritable one = new IntWritable(1);
    private Text movieInfo = new Text();
    
    @Override
    public void map(LongWritable key, Text value, Context context) 
            throws IOException, InterruptedException {
        
        // 解析输入数据：userId,movieId,rating,movieTitle
        String line = value.toString().trim();
        if (line.isEmpty()) {
            return;
        }
        
        String[] fields = line.split(",");
        if (fields.length >= 4) {
            String movieId = fields[1].trim();
            String movieTitle = fields[3].trim();
            
            // 输出：(movieId:movieTitle, 1)
            movieInfo.set(movieId + ":" + movieTitle);
            context.write(movieInfo, one);
        }
    }
}