class AppointmentsController < ApplicationController
  
  def main
  end
  
  def show
    @doctor = Doctor.all.load_async
    @patient = Patient.all.load_async
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
  
  def index
    if patient_signed_in?
      @patient = current_patient 
      @appointments = @patient.appointments 
    end 
    if doctor_signed_in?
      @doctor = current_doctor
      @appointments = @doctor.appointments.includes(:patient)
    end
    respond_to do |format|
      format.html # Render HTML format
    end
  end

  def new
    @appointment = Appointment.new
  end

  def create

    @patient = current_patient
    @appointment = @patient.appointments.new(appointment_params)
    @appointment.doctor_id = Doctor.find_by_name(@appointment.doctor_name)&.id
    
    if @appointment.save
      
      broadcast_to_appointments(@appointment)
      redirect_to appointments_path

    else

      render 'new', status: :unprocessable_entity
      
    end

  end

  def edit

    @appointment = Appointment.find(params[:id])

  end

  def update

    @appointment = Appointment.find(params[:id])
    @appointment.assign_attributes(appointment_params)
    @appointment.doctor_id = Doctor.find_by_name(@appointment.doctor_name)&.id
    if @appointment.update(appointment_params)

      broadcast_to_appointments(@appointment)
      redirect_to appointments_path#(format: :html)
      
    else
      render 'edit' , status: :unprocessable_entity
    end

  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path,  status: :see_other
  end

  private

  def appointment_params

    params.require(:appointment).permit(:appointment_date, :appointment_time, :disease, :doctor_name)

  end

  def broadcast_to_appointments(appointment)
    turbo_stream.append("appointments",partial: "appointments/appointment",locals: { appointment: appointment })
  end

end
