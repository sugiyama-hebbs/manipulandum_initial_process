# Set a function to perform SG filter on position data (smoothing and derivatives) to
# filter data as well as calculate velocity, acceleration, and jerk
# Modified function from Fujita
#
# Author: Taisei Sugiyama
# Date created: 04/13/2021

process_kin <- function(df, reduce_hz, reduce_hz_rate){

# pos_data_tri <- subset(pos_data, trial == tri) 

x <- df$x # raw x position
y <- df$y # raw y position

## SG filtering (smoothing & derivatives).
# x
sx <- sgolayfilt(x, p = order, n = framelen, m = 0, ts = 1/sample_rate) # smooth
svx <- sgolayfilt(x, p = order, n = framelen, m = 1, ts = 1/sample_rate) # velocity
sax <- sgolayfilt(x, p = order, n = framelen, m = 2, ts = 1/sample_rate) # acceleration
sjx <- sgolayfilt(x, p = order, n = framelen, m = 3, ts = 1/sample_rate) # jerk

# y
sy <- sgolayfilt(y, p = order, n = framelen, m = 0, ts = 1/sample_rate) # smooth
svy <- sgolayfilt(y, p = order, n = framelen, m = 1, ts = 1/sample_rate) # velocity
say <- sgolayfilt(y, p = order, n = framelen, m = 2, ts = 1/sample_rate) # acceleration
sjy <- sgolayfilt(y, p = order, n = framelen, m = 3, ts = 1/sample_rate) # jerk

vx <- df$vx # robot x-velocity
vy <- df$vy # robot y-velocity
state <- df$state # trial state


if (reduce_hz) {
  return_df <- data.frame(tstep = 1:length(x), state, x, y, vx, vy, sx, sy, svx, svy, sax, say, sjx, sjy, fx = df$fs_x, fy = df$fs_y)  %>% 
    # dplyr::filter(tstep %% red_rate == 1) # reduce sample Hz
    dplyr::filter(tstep %% reduce_hz_rate == 1) # reduce sample Hz
} else{
  return_df <- data.frame(tstep = 1:length(x), state, x, y, vx, vy, sx, sy, svx, svy, sax, say, sjx, sjy, fx = df$fs_x, fy = df$fs_y)
}



# ## Checking
# # trajectory
# tmp_traj <- ggplot(return_df, aes(x = tstep)) +
#   geom_hline(yintercept = 0, linetype="dashed") +
#   geom_path(aes(y = sy), color = "red") +
#   geom_path(aes(y = y), color = "blue", alpha = .5)
# # 
# # # velocity
# tmp_vel <- ggplot(return_df, aes(x = tstep)) +
#   geom_hline(yintercept = 0, linetype="dashed") +
#   geom_path(aes(y = svy), color = "red") +
#   geom_path(aes(y = vy), color = "blue", alpha = .5)
# # 
# # # acceleration
# tmp_acc <- ggplot(return_df, aes(x = tstep)) +
#   geom_hline(yintercept = 0, linetype="dashed") +
#   geom_path(aes(y = say), color = "red")
# # 
# # # jerk
# tmp_jerk <- ggplot(return_df, aes(x = tstep)) +
#   geom_hline(yintercept = 0, linetype="dashed") +
#   geom_path(aes(y = sjy), color = "red")
# 
# grid.arrange(tmp_traj,tmp_vel,tmp_acc, tmp_jerk, ncol = 1)
}
